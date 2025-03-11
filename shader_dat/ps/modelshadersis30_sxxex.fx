sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
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
sampler specularmap_sampler : register(s5);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
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
	float3 r4;
	float3 r5;
	r0.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = -i.texcoord1.xyz * r0.xxx + lightpos.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, i.texcoord3.xyz);
	r1.x = pow(r0.x, specularParam.z);
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.z = (-r0.y >= 0) ? 0 : 1;
	r0.x = (-r0.x >= 0) ? 0 : r0.z;
	r0.z = r0.y * r0.z;
	r1.yzw = r0.yyy * light_Color.xyz;
	r0.yzw = r0.zzz * light_Color.xyz;
	r0.x = r1.x * r0.x;
	r0.xyz = r0.xxx * r0.yzw;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r3 = tex2D(specularmap_sampler, r2);
	r2 = tex2D(Color_1_sampler, r2);
	r0.xyz = r0.xyz * r3.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r0.xyz = r0.www * r0.xyz;
	r1.x = abs(specularParam.x);
	r0.xyz = r0.xyz * r1.xxx;
	r3.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r3.xyz);
	r1.x = dot(r4.xyz, i.texcoord3.xyz);
	r3.xyz = r1.xxx * point_light1.xyz;
	r3.xyz = r3.xyz * i.texcoord8.xxx;
	r4.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r4.xyz);
	r1.x = dot(r5.xyz, i.texcoord3.xyz);
	r4.xyz = r1.xxx * muzzle_light.xyz;
	r3.xyz = r4.xyz * i.texcoord8.zzz + r3.xyz;
	r1.xyz = r1.yzw * r0.www + r3.xyz;
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r1.xyz = r1.xyz * r2.xyz;
	r3.xyz = r2.xyz * ambient_rate.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r1.xyz = r3.xyz * ambient_rate_rate.xyz + r1.xyz;
	r0.xyz = r0.xyz * r2.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
