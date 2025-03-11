sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s3);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float2 g_ShadowFarInvPs : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
sampler normalmap_sampler : register(s4);
float4 prefogcolor_enhance : register(c77);
float4 tile : register(c43);

struct PS_IN
{
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
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r0 = tex2D(A_Occ_sampler, r0);
	r2 = r1.w + -0.01;
	clip(r2);
	r2.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r2.x), abs(r2.y));
	r0.w = r0.w + -0.015625;
	r2.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r2.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r0.w = 1 / ambient_rate.w;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(ShadowCast_Tex_sampler, r2);
	r0.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r0.w = -r0.w + 1;
	r0.w = -r2.x + r0.w;
	r0.w = r0.w + g_ShadowUse.x;
	r1.w = frac(-r0.w);
	r0.w = r0.w + r1.w;
	r2.xyz = ambient_rate_rate.xyz;
	r2.xyz = r0.www * r2.xyz + ambient_rate.xyz;
	r3.xy = -r0.yy + r0.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.xz = (r0.ww >= 0) ? r0.yy : r0.xz;
	r2.xyz = r0.xyz * r2.xyz + i.texcoord2.xyz;
	r2.xyz = r1.xyz * r2.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3.xyz = r0.xyz * r3.xyz;
	r0 = r3 * ambient_rate_rate.w;
	r3.xy = g_All_Offset.xy;
	r3.xy = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r3);
	r0.xyz = r0.xyz * r3.www;
	r0.w = r0.w * CubeParam.y + CubeParam.x;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = r1.xyz * r0.xyz;
	r3.xyz = r1.xyz * CubeParam.zzz + r2.xyz;
	r1.xyz = r1.xyz * CubeParam.zzz;
	r1.xyz = r2.xyz * -r1.xyz + r3.xyz;
	r2.z = CubeParam.z;
	r0.w = -r2.z + 1;
	r0.xyz = r0.xyz * r0.www + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;

	return o;
}
