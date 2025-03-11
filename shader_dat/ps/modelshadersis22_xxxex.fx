sampler Color_1_sampler : register(s0);
sampler ShadowCast_Tex_sampler : register(s10);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
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
	float2 texcoord : TEXCOORD;
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
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.x = 1 / i.texcoord7.w;
	r1.xy = r1.xx * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(ShadowCast_Tex_sampler, r1);
	r1.y = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r1.y = -r1.y + 1;
	r1.x = -r1.x + r1.y;
	r1.x = r1.x + g_ShadowUse.x;
	r1.y = frac(-r1.x);
	r1.x = r1.y + r1.x;
	r1.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.xyz = normalize(r1.yzw);
	r3.xyz = i.texcoord3.xyz;
	r1.yzw = r3.yzx * i.texcoord2.zxy;
	r1.yzw = i.texcoord2.yzx * r3.zxy + -r1.yzw;
	r3.xy = g_All_Offset.xy;
	r3.xy = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r3);
	r3.xyz = r3.xyz + -0.5;
	r1.yzw = r1.yzw * -r3.yyy;
	r2.w = r3.x * i.texcoord2.w;
	r1.yzw = r2.www * i.texcoord2.xyz + r1.yzw;
	r1.yzw = r3.zzz * i.texcoord3.xyz + r1.yzw;
	r3.xyz = normalize(r1.yzw);
	r1.y = dot(r2.xyz, r3.xyz);
	r1.yzw = r1.yyy * point_light1.xyz;
	r1.yzw = r1.yzw * i.texcoord8.xxx;
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r2.xyz);
	r2.x = dot(r4.xyz, r3.xyz);
	r2.xyz = r2.xxx * muzzle_light.xyz;
	r1.yzw = r2.xyz * i.texcoord8.zzz + r1.yzw;
	r2.x = dot(lightpos.xyz, r3.xyz);
	r2.y = r2.x;
	r4.xyz = r2.yyy * light_Color.xyz;
	r1.yzw = r4.xyz * r1.xxx + r1.yzw;
	r2.zw = -r0.yy + r0.xz;
	r4.x = max(abs(r2.z), abs(r2.w));
	r2.z = r4.x + -0.015625;
	r2.w = (-r2.z >= 0) ? 0 : 1;
	r2.z = (r2.z >= 0) ? -0 : -1;
	r2.z = r2.z + r2.w;
	r2.z = (r2.z >= 0) ? -r2.z : -0;
	r0.xz = (r2.zz >= 0) ? r0.yy : r0.xz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r1.yzw = r1.yzw * r0.xyz;
	r4.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r4.xyz = r4.xyz * ambient_rate_rate.xyz;
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = -r0.w + r2.x;
	r0.w = r0.w + 1;
	r1.yzw = r4.xyz * r0.www + r1.yzw;
	r0.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r2.xzw = -i.texcoord1.xyz * r0.www + lightpos.xyz;
	r4.xyz = normalize(r2.xzw);
	r0.w = dot(r4.xyz, r3.xyz);
	r2.x = pow(r0.w, specularParam.z);
	r2.z = (-r2.y >= 0) ? 0 : 1;
	r2.y = r2.y * r2.z;
	r0.w = (-r0.w >= 0) ? 0 : r2.z;
	r0.w = r2.x * r0.w;
	r2.xyz = r2.yyy * light_Color.xyz;
	r2.xyz = r0.www * r2.xyz;
	r2.xyz = r3.www * r2.xyz;
	r2.xyz = r1.xxx * r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.yzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
