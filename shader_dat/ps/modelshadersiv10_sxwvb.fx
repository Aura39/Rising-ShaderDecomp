sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
sampler cubemap_mask_sampler : register(s5);
samplerCUBE cubemap_sampler : register(s3);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 prefogcolor_enhance : register(c77);
float4 tile : register(c43);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r2.xy = -r1.yy + r1.xz;
	r1.w = max(abs(r2.x), abs(r2.y));
	r1.w = r1.w + -0.015625;
	r2.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r1.xz = (r1.ww >= 0) ? r1.yy : r1.xz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.zw + r2.xy;
	r2 = tex2D(Color_2_sampler, r2);
	r3.xy = -r2.yy + r2.xz;
	r1.w = max(abs(r3.x), abs(r3.y));
	r1.w = r1.w + -0.015625;
	r3.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r3.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r2.xz = (r1.ww >= 0) ? r2.yy : r2.xz;
	r1.w = r2.w * i.color.w;
	r2.w = r2.w * -i.color.w + 1;
	r3.xyz = lerp(r2.xyz, r1.xyz, r1.www);
	r1.x = 1 / ambient_rate.w;
	r1.xyz = r1.xxx * r3.xyz;
	r1.xyz = r1.xyz * i.color.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r2 = r2.w * r3;
	r3 = tex2D(A_Occ_sampler, r0);
	r0 = tex2D(cubemap_mask_sampler, r0.zwzw);
	r4.xy = -r3.yy + r3.xz;
	r0.w = max(abs(r4.x), abs(r4.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r3.xz = (r0.ww >= 0) ? r3.yy : r3.xz;
	r2.xyz = r2.xyz * r3.xyz;
	r2 = r2 * ambient_rate_rate.w;
	r0.xyz = r0.xyz * r2.xyz;
	r0.w = r2.w * CubeParam.y + CubeParam.x;
	r0.xyz = r0.www * r0.xyz;
	r2.xyz = r1.xyz * r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r4.xy = r0.ww * i.texcoord7.xy;
	r4.xy = r4.xy * float2(0.5, -0.5) + 0.5;
	r4.xy = r4.xy + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r4);
	r0.w = r4.z + g_ShadowUse.x;
	r4.xyz = ambient_rate_rate.xyz;
	r4.xyz = r0.www * r4.xyz + ambient_rate.xyz;
	r3.xyz = r3.xyz * r4.xyz + i.texcoord2.xyz;
	r1.xyz = r1.xyz * r3.xyz;
	r3.xyz = r2.xyz * CubeParam.zzz + r1.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r2.xyz + r3.xyz;
	r2.y = 1;
	r0.w = r2.y + -CubeParam.z;
	r0.xyz = r0.xyz * r0.www + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
