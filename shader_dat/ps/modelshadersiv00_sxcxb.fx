sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
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
	float2 texcoord : TEXCOORD;
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
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r1.xy = g_All_Offset.xy;
	r1.xy = i.texcoord.xy * tile.zw + r1.xy;
	r1 = tex2D(Color_2_sampler, r1);
	r2.xy = -r1.yy + r1.xz;
	r3.x = max(abs(r2.x), abs(r2.y));
	r2.x = r3.x + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r1.xz = (r2.xx >= 0) ? r1.yy : r1.xz;
	r2.x = r1.w * i.color.w;
	r1.w = r1.w * -i.color.w + 1;
	r3.xyz = lerp(r1.xyz, r0.xyz, r2.xxx);
	r0.x = 1 / ambient_rate.w;
	r0.xyz = r0.xxx * r3.xyz;
	r2 = tex2D(cubemap_sampler, i.texcoord4);
	r1 = r1.w * r2;
	r1 = r1 * ambient_rate_rate.w;
	r1.xyz = r0.www * r1.xyz;
	r0.w = r1.w * CubeParam.y + CubeParam.x;
	r1.xyz = r0.www * r1.xyz;
	r2.xyz = r0.xyz * r1.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r3.xyz = ambient_rate_rate.xyz;
	r3.xyz = r0.www * r3.xyz + ambient_rate.xyz;
	r3.xyz = r3.xyz + i.texcoord2.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r3.xyz = r2.xyz * CubeParam.zzz + r0.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r2.xyz + r3.xyz;
	r2.y = 1;
	r0.w = r2.y + -CubeParam.z;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
