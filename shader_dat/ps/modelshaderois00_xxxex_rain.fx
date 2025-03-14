sampler Color_1_sampler : register(s0);
sampler RainNormal_sampler : register(s9);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 g_testUvParam : register(c179);
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
	float3 r4;
	float3 r5;
	float4 r6;
	float4 r7;
	r0.xyz = i.texcoord3.xyz;
	r1.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r1.xyz;
	r1.xy = g_All_Offset.xy;
	r1.xy = i.texcoord.xy * tile.xy + r1.xy;
	r1 = tex2D(normalmap_sampler, r1);
	r1.xyz = r1.xyz + -0.5;
	r2.xy = i.texcoord.xy * g_testUvParam.zz + g_testUvParam.xy;
	r2 = tex2D(RainNormal_sampler, r2);
	r2.xy = r2.xy + -0.5;
	r1.xy = r2.xy * g_testUvParam.ww + r1.xy;
	r0.w = dot(r2.w, r2.w) + 0;
	r0.w = 1 / sqrt(r0.w);
	r0.w = 1 / r0.w;
	r0.xyz = r0.xyz * -r1.yyy;
	r1.x = r1.x * i.texcoord2.w;
	r0.xyz = r1.xxx * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r1.zzz * i.texcoord3.xyz + r0.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r2.xyz = -i.texcoord1.xyz * r0.xxx + lightpos.xyz;
	r3.xyz = normalize(r2.xyz);
	r0.y = dot(r3.xyz, r1.xyz);
	r1.w = pow(r0.y, specularParam.z);
	r0.z = dot(lightpos.xyz, r1.xyz);
	r2.x = r0.z;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r0.y = (-r0.y >= 0) ? 0 : r2.y;
	r2.y = r2.x * r2.y;
	r2.xzw = r2.xxx * light_Color.xyz;
	r3.xyz = r2.yyy * light_Color.xyz;
	r0.y = r1.w * r0.y;
	r3.xyz = r0.yyy * r3.xyz;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r4.xyz);
	r4.xyz = -i.texcoord1.xyz * r0.xxx + r5.xyz;
	r0.x = dot(r5.xyz, r1.xyz);
	r5.xyz = normalize(r4.xyz);
	r0.y = dot(r5.xyz, r1.xyz);
	r1.w = (-r0.x >= 0) ? 0 : 1;
	r2.y = (-r0.y >= 0) ? 0 : r1.w;
	r3.w = pow(r0.y, specularParam.z);
	r0.y = r2.y * r3.w;
	r1.w = r0.x * r1.w;
	r4.xyz = r0.xxx * point_light1.xyz;
	r4.xyz = r4.xyz * i.texcoord8.xxx;
	r5.xyz = r1.www * point_light1.xyz;
	r5.xyz = r0.yyy * r5.xyz;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r6 = tex2D(Color_1_sampler, r0);
	r5.xyz = r5.xyz * r6.www;
	r5.xyz = r5.xyz * 0.5;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r7 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r7.z + g_ShadowUse.x;
	r0.y = r6.w * r0.x + r0.w;
	r3.xyz = r3.xyz * r0.yyy + r5.xyz;
	r0.y = abs(specularParam.x);
	r3.xyz = r0.yyy * r3.xyz;
	r5.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r7.xyz = normalize(r5.xyz);
	r0.y = dot(r7.xyz, r1.xyz);
	r1.xyz = r0.yyy * muzzle_light.xyz;
	r1.xyz = r1.xyz * i.texcoord8.zzz + r4.xyz;
	r1.xyz = r2.xzw * r0.xxx + r1.xyz;
	r0.x = -r0.x + 1;
	r1.xyz = r1.xyz * r6.xyz;
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.y = -r0.y + r0.z;
	r0.y = r0.y + 1;
	r2.xyz = r6.xyz * i.texcoord5.xyz;
	r0.xzw = r0.xxx * r2.xyz;
	r2.xyz = r6.xyz * ambient_rate.xyz;
	r4.xyz = r6.xyz + specularParam.www;
	r0.xzw = r2.xyz * ambient_rate_rate.xyz + r0.xzw;
	r0.xyz = r0.xzw * r0.yyy + r1.xyz;
	r0.xyz = r3.xyz * r4.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
