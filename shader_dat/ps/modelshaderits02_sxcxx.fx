sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s2);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float2 g_ShadowFarInvPs : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s3);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 tile : register(c43);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
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
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r0.xyz, r0.xyz);
	r0.w = 1 / sqrt(r0.w);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightpos1.w;
	r0.w = r0.w * point_light1.w;
	r0.x = dot(r0.xyz, i.texcoord3.xyz);
	r0.xyz = abs(r0.xxx) * point_light1.xyz;
	r0.xyz = r0.www * r0.xyz;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + muzzle_lightpos.w;
	r0.w = r0.w * muzzle_light.w;
	r1.x = dot(r1.xyz, i.texcoord3.xyz);
	r1.xyz = abs(r1.xxx) * muzzle_light.xyz;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(ShadowCast_Tex_sampler, r1);
	r0.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r0.w = -r0.w + 1;
	r0.w = -r1.x + r0.w;
	r0.w = r0.w + g_ShadowUse.x;
	r1.x = frac(-r0.w);
	r0.w = r0.w + r1.x;
	r1.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.xyz = abs(r1.xxx) * light_Color.xyz;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r1 = g_All_Offset + i.texcoord;
	r2 = tex2D(Color_1_sampler, r1);
	r1 = tex2D(Color_2_sampler, r1.zwzw);
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r2.xyz = r1.xyz + r2.xyz;
	r0.w = dot(r1.xyz, 0.298912);
	r0.w = r0.w + r2.x;
	r0.xyz = r0.xyz * r2.xyz;
	r1.xyz = r2.xyz * ambient_rate.xyz;
	r0.xyz = r1.xyz * ambient_rate_rate.xyz + r0.xyz;
	r1.xy = g_All_Offset.xy;
	r1.xy = i.texcoord.xy * tile.xy + r1.xy;
	r1 = tex2D(normalmap_sampler, r1);
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r1.xyz = r1.www * r3.xyz;
	r1.w = r3.w * CubeParam.y + CubeParam.x;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = r2.xyz * r1.xyz;
	r3.xyz = r2.xyz * CubeParam.zzz + r0.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r2.xyz + r3.xyz;
	r2.z = CubeParam.z;
	r1.w = -r2.z + 1;
	r0.xyz = r1.xyz * r1.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	r0.x = max(CubeParam.x, CubeParam.y);
	r0.x = r0.x * r3.w;
	r1.x = max(r0.x, r0.w);
	r0.x = r1.x * prefogcolor_enhance.w;
	o.w = r0.x;

	return o;
}
