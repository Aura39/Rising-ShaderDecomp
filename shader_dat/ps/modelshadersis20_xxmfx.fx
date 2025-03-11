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
sampler normalmap_sampler : register(s4);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
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
	float4 r4;
	float3 r5;
	float3 r6;
	float3 r7;
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.xyz = i.texcoord3.xyz;
	r2.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r2.xyz;
	r2.xy = g_All_Offset.xy;
	r2.xy = i.texcoord.xy * tile.xy + r2.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r0.xyz = r0.xyz * -r2.yyy;
	r0.w = r2.x * i.texcoord2.w;
	r0.xyz = r0.www * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r2.zzz * i.texcoord3.xyz + r0.xyz;
	r2.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, r2.xyz);
	r0.xyz = r0.xxx * point_light1.xyz;
	r0.xyz = r0.xyz * i.texcoord8.xxx;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r1.xyz);
	r0.w = dot(r3.xyz, r2.xyz);
	r1.xyz = r0.www * muzzle_light.xyz;
	r0.xyz = r1.xyz * i.texcoord8.zzz + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = dot(lightpos.xyz, r2.xyz);
	r1.y = r1.x;
	r3.xyz = r1.yyy * light_Color.xyz;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r1.z = r1.y + -0.5;
	r2.w = max(r1.z, 0);
	r3 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r4 = tex2D(A_Occ_sampler, r3);
	r3 = tex2D(Color_1_sampler, r3.zwzw);
	r1.zw = -r4.yy + r4.xz;
	r4.w = max(abs(r1.z), abs(r1.w));
	r1.z = r4.w + -0.015625;
	r1.w = (-r1.z >= 0) ? 0 : 1;
	r1.z = (r1.z >= 0) ? -0 : -1;
	r1.z = r1.z + r1.w;
	r1.z = (r1.z >= 0) ? -r1.z : -0;
	r4.xz = (r1.zz >= 0) ? r4.yy : r4.xz;
	r5.xyz = r2.www + r4.xyz;
	r1.zw = -r3.yy + r3.xz;
	r2.w = max(abs(r1.z), abs(r1.w));
	r1.z = r2.w + -0.015625;
	r1.w = (-r1.z >= 0) ? 0 : 1;
	r1.z = (r1.z >= 0) ? -0 : -1;
	r1.z = r1.z + r1.w;
	r1.z = (r1.z >= 0) ? -r1.z : -0;
	r3.xz = (r1.zz >= 0) ? r3.yy : r3.xz;
	r6.xyz = r3.xyz * i.color.xyz;
	r3.xyz = r3.xyz * i.color.xyz + specularParam.www;
	r7.xyz = r5.xyz * r6.xyz;
	r4.xyz = r4.xyz * r6.xyz;
	r4.xyz = r4.xyz * ambient_rate.xyz;
	r4.xyz = r4.xyz * ambient_rate_rate.xyz;
	r0.xyz = r0.xyz * r7.xyz;
	r1.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = -r1.z + r1.x;
	r1.x = r1.x + 1;
	r0.xyz = r4.xyz * r1.xxx + r0.xyz;
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r1.xzw = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r4.xyz = normalize(r1.xzw);
	r1.x = dot(r4.xyz, r2.xyz);
	r2.x = pow(r1.x, specularParam.z);
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = r1.y * r1.z;
	r1.x = (-r1.x >= 0) ? 0 : r1.z;
	r1.x = r2.x * r1.x;
	r1.yzw = r1.yyy * light_Color.xyz;
	r1.xyz = r1.xxx * r1.yzw;
	r1.xyz = r3.www * r1.xyz;
	r1.xyz = r0.www * r1.xyz;
	r1.xyz = r5.xyz * r1.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r3.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
