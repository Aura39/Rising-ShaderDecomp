sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
sampler Spec_Pow_sampler : register(s4);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord5 : TEXCOORD5;
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
	r1 = r0.w + -0.8;
	clip(r1);
	r1.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.w = dot(r2.xyz, i.texcoord3.xyz);
	r1.xyz = r0.www * point_light1.xyz;
	r1.xyz = r1.xyz * i.texcoord8.xxx;
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r2.xyz);
	r0.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.xyz = r0.www * muzzle_light.xyz;
	r1.xyz = r2.xyz * i.texcoord8.zzz + r1.xyz;
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.xyz = r0.www * light_Color.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r1.xyz = r2.xyz * r0.www + r1.xyz;
	r1.w = -r0.w + 1;
	r2.xy = -r0.yy + r0.xz;
	r3.x = max(abs(r2.x), abs(r2.y));
	r2.x = r3.x + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r0.xz = (r2.xx >= 0) ? r0.yy : r0.xz;
	r2.xyz = r0.xyz * i.texcoord5.xyz;
	r2.xyz = r1.www * r2.xyz;
	r3.xyz = r0.xyz * ambient_rate.xyz;
	r2.xyz = r3.xyz * ambient_rate_rate.xyz + r2.xyz;
	r1.xyz = r0.xyz * r1.xyz + r2.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r3.xyz = normalize(r2.xyz);
	r1.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.x = -r1.w + 1;
	r2.x = r2.x * -specularParam.z + r1.w;
	r2.y = specularParam.y;
	r2 = tex2D(Spec_Pow_sampler, r2);
	r2.xyz = r2.xyz * light_Color.xyz;
	r2.xyz = r0.www * r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
