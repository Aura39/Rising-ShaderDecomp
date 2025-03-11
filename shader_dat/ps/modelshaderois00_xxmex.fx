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
sampler normalmap_sampler : register(s3);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);
sampler tripleMask_sampler : register(s1);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
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
	float4 r4;
	float3 r5;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = -r0.x + 1;
	r0.zw = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r0.zw = -r1.yy + r1.xz;
	r1.w = max(abs(r0.z), abs(r0.w));
	r0.z = r1.w + -0.015625;
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r0.w;
	r0.z = (r0.z >= 0) ? -r0.z : -0;
	r1.xz = (r0.zz >= 0) ? r1.yy : r1.xz;
	r2.xyz = r1.xyz * i.texcoord5.xyz;
	r0.yzw = r0.yyy * r2.xyz;
	r2.xyz = r1.xyz * ambient_rate.xyz;
	r0.yzw = r2.xyz * ambient_rate_rate.xyz + r0.yzw;
	r2.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r2.xyz);
	r2.xyz = i.texcoord3.xyz;
	r4.xyz = r2.yzx * i.texcoord2.zxy;
	r2.xyz = i.texcoord2.yzx * r2.zxy + -r4.xyz;
	r4.xy = tile.xy;
	r4.xy = i.texcoord.xy * r4.xy + g_All_Offset.xy;
	r4 = tex2D(normalmap_sampler, r4);
	r4.xyz = r4.xyz + -0.5;
	r2.xyz = r2.xyz * -r4.yyy;
	r1.w = r4.x * i.texcoord2.w;
	r2.xyz = r1.www * i.texcoord2.xyz + r2.xyz;
	r2.xyz = r4.zzz * i.texcoord3.xyz + r2.xyz;
	r4.xyz = normalize(r2.xyz);
	r1.w = dot(r3.xyz, r4.xyz);
	r2.xyz = r1.www * point_light1.xyz;
	r2.xyz = r2.xyz * i.texcoord8.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r1.w = dot(r5.xyz, r4.xyz);
	r3.xyz = r1.www * muzzle_light.xyz;
	r2.xyz = r3.xyz * i.texcoord8.zzz + r2.xyz;
	r1.w = dot(lightpos.xyz, r4.xyz);
	r2.w = r1.w;
	r3.xyz = r2.www * light_Color.xyz;
	r2.xyz = r3.xyz * r0.xxx + r2.xyz;
	r2.xyz = r1.xyz * r2.xyz;
	r1.xyz = r1.xyz + specularParam.www;
	r3.xy = tile.xy * i.texcoord.xy;
	r3 = tex2D(tripleMask_sampler, r3);
	r2.xyz = r2.xyz * r3.www;
	r3.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = r1.w + -r3.x;
	r1.w = r1.w + 1;
	r0.yzw = r0.yzw * r1.www + r2.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r5.xyz = normalize(r2.xyz);
	r1.w = dot(r5.xyz, r4.xyz);
	r2.x = pow(r1.w, specularParam.z);
	r2.y = (-r2.w >= 0) ? 0 : 1;
	r2.z = r2.w * r2.y;
	r1.w = (-r1.w >= 0) ? 0 : r2.y;
	r1.w = r2.x * r1.w;
	r2.xyz = r2.zzz * light_Color.xyz;
	r2.xyz = r1.www * r2.xyz;
	r2.xyz = r3.zzz * r2.xyz;
	r2.xyz = r0.xxx * r2.xyz;
	r0.x = abs(specularParam.x);
	r2.xyz = r0.xxx * r2.xyz;
	r0.xyz = r2.xyz * r1.xyz + r0.yzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
