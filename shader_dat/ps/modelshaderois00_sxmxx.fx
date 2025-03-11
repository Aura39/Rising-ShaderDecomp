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
float4 tile : register(c43);
sampler tripleMask_sampler : register(s1);

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
	float3 r3;
	float3 r4;
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
	r1.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.xyz = r1.www * point_light1.xyz;
	r2.xyz = r2.xyz * i.texcoord8.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r3.xyz);
	r1.w = dot(r4.xyz, i.texcoord3.xyz);
	r3.xyz = r1.www * muzzle_light.xyz;
	r2.xyz = r3.xyz * i.texcoord8.zzz + r2.xyz;
	r1.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r3.xyz = r1.www * light_Color.xyz;
	r2.xyz = r3.xyz * r0.xxx + r2.xyz;
	r1.xyz = r1.xyz * r2.xyz;
	r2.xy = tile.xy * i.texcoord.xy;
	r2 = tex2D(tripleMask_sampler, r2);
	r0.xyz = r1.xyz * r2.www + r0.yzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
