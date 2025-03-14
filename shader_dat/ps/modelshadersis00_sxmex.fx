sampler A_Occ_sampler : register(s2);
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

struct PS_IN
{
	float4 texcoord : TEXCOORD;
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
	float3 r3;
	float3 r4;
	float3 r5;
	float3 r6;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r0.yzw = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r1.xyz = normalize(r0.yzw);
	r0.y = dot(r1.xyz, i.texcoord3.xyz);
	r1.x = pow(r0.y, specularParam.z);
	r0.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = r0.z * r0.w;
	r0.y = (-r0.y >= 0) ? 0 : r0.w;
	r0.y = r1.x * r0.y;
	r1.xyz = r0.zzz * light_Color.xyz;
	r0.yzw = r0.yyy * r1.xyz;
	r1 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r2 = tex2D(Color_1_sampler, r1.zwzw);
	r1 = tex2D(A_Occ_sampler, r1);
	r0.yzw = r0.yzw * r2.www;
	r0.yzw = r0.xxx * r0.yzw;
	r3.xyz = ambient_rate.xyz;
	r3.xyz = r0.xxx * ambient_rate_rate.xyz + r3.xyz;
	r4.xy = -r1.yy + r1.xz;
	r0.x = max(abs(r4.x), abs(r4.y));
	r0.x = r0.x + -0.015625;
	r1.w = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r1.w;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r1.xz = (r0.xx >= 0) ? r1.yy : r1.xz;
	r0.xyz = r0.yzw * r1.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r4.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r4.x), abs(r4.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r0.w = 1 / ambient_rate.w;
	r4.xyz = r2.xyz * r0.www + specularParam.www;
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r0.xyz * r4.xyz;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r4.xyz);
	r0.w = dot(r5.xyz, i.texcoord3.xyz);
	r4.xyz = r0.www * point_light1.xyz;
	r4.xyz = r4.xyz * i.texcoord8.xxx;
	r5.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r6.xyz = normalize(r5.xyz);
	r0.w = dot(r6.xyz, i.texcoord3.xyz);
	r5.xyz = r0.www * muzzle_light.xyz;
	r4.xyz = r5.xyz * i.texcoord8.zzz + r4.xyz;
	r1.xyz = r1.xyz * r3.xyz + r4.xyz;
	r0.xyz = r2.xyz * r1.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
