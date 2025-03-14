sampler A_Occ_sampler : register(s2);
sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
sampler Spec_Pow_sampler : register(s6);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s3);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float2 g_ShadowFarInvPs : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s4);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r0 = tex2D(A_Occ_sampler, r0);
	r2 = r1.w + -0.01;
	clip(r2);
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r2.xyz);
	r0.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.xyz = r0.www * point_light1.xyz;
	r2.xyz = r2.xyz * i.texcoord8.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r3.xyz);
	r0.w = dot(r4.xyz, i.texcoord3.xyz);
	r3.xyz = r0.www * muzzle_light.xyz;
	r2.xyz = r3.xyz * i.texcoord8.zzz + r2.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(ShadowCast_Tex_sampler, r3);
	r0.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r0.w = -r0.w + 1;
	r0.w = -r3.x + r0.w;
	r0.w = r0.w + g_ShadowUse.x;
	r2.w = frac(-r0.w);
	r0.w = r0.w + r2.w;
	r2.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r3.xyz = r2.www * light_Color.xyz;
	r2.w = r2.w + -0.5;
	r3.w = max(r2.w, 0);
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r3.xy = -r0.yy + r0.xz;
	r2.w = max(abs(r3.x), abs(r3.y));
	r2.w = r2.w + -0.015625;
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r0.xz = (r2.ww >= 0) ? r0.yy : r0.xz;
	r3.xyz = r3.www + r0.xyz;
	r4.xy = -r1.yy + r1.xz;
	r2.w = max(abs(r4.x), abs(r4.y));
	r2.w = r2.w + -0.015625;
	r3.w = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.w;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r1.xz = (r2.ww >= 0) ? r1.yy : r1.xz;
	r1.w = r1.w * prefogcolor_enhance.w;
	o.w = r1.w;
	r4.xyz = r3.xyz * r1.xyz;
	r2.xyz = r2.xyz * r4.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz + r2.xyz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r4 = tex2D(cubemap_sampler, i.texcoord4);
	r4 = r4 * ambient_rate_rate.w;
	r2.xyz = r2.www * r4.xyz;
	r1.w = r4.w * CubeParam.y + CubeParam.x;
	r2.xyz = r1.www * r2.xyz;
	r2.xyz = r3.xyz * r2.xyz;
	r4.xyz = r1.xyz * r2.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r5.xyz = r4.xyz * CubeParam.zzz + r0.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r4.xyz + r5.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r4.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r5.xyz = normalize(r4.xyz);
	r1.w = dot(r5.xyz, i.texcoord3.xyz);
	r2.w = -r1.w + 1;
	r4.x = r2.w * -specularParam.z + r1.w;
	r4.y = specularParam.y;
	r4 = tex2D(Spec_Pow_sampler, r4);
	r4.xyz = r4.xyz * light_Color.xyz;
	r4.xyz = r0.www * r4.xyz;
	r3.xyz = r3.xyz * r4.xyz;
	r0.w = abs(specularParam.x);
	r3.xyz = r0.www * r3.xyz;
	r0.xyz = r3.xyz * r1.xyz + r0.xyz;
	r1.z = 1;
	r0.w = r1.z + -CubeParam.z;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
