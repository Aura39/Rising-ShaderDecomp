sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s2);
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
float4 tile : register(c43);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
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
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, i.texcoord3.xyz);
	r0.xyz = r0.xxx * point_light1.xyz;
	r0.xyz = r0.xyz * i.texcoord8.xxx;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.w = dot(r2.xyz, i.texcoord3.xyz);
	r1.xyz = r0.www * muzzle_light.xyz;
	r0.xyz = r1.xyz * i.texcoord8.zzz + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.yzw = r1.xxx * light_Color.xyz;
	r1.x = r1.x * 0.5 + 0.5;
	r0.xyz = r1.yzw * r0.www + r0.xyz;
	r0.w = -r0.w + 1;
	r1.yz = g_All_Offset.xy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r1.yzzw);
	r1.yz = -r2.yy + r2.xz;
	r2.w = max(abs(r1.y), abs(r1.z));
	r1.y = r2.w + -0.015625;
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r1.z;
	r1.y = (r1.y >= 0) ? -r1.y : -0;
	r2.xz = (r1.yy >= 0) ? r2.yy : r2.xz;
	r1.yzw = r2.xyz * i.texcoord5.xyz;
	r1.yzw = r0.www * r1.yzw;
	r3.xyz = r2.xyz * ambient_rate.xyz;
	r1.yzw = r3.xyz * ambient_rate_rate.xyz + r1.yzw;
	r0.xyz = r2.xyz * r0.xyz + r1.yzw;
	r3.xy = g_All_Offset.xy;
	r1.yz = i.texcoord.xy * tile.xy + r3.xy;
	r3 = tex2D(normalmap_sampler, r1.yzzw);
	r4 = tex2D(cubemap_sampler, i.texcoord4);
	r4 = r4 * ambient_rate_rate.w;
	r4.xyz = r3.www * r4.xyz;
	r1 = r1.x * r4;
	r0.w = r1.w * CubeParam.y + CubeParam.x;
	r1.xyz = r0.www * r1.xyz;
	r2.xyz = r2.xyz * r1.xyz;
	r3.xyz = r2.xyz * CubeParam.zzz + r0.xyz;
	r2.xyz = r2.xyz * CubeParam.zzz;
	r0.xyz = r0.xyz * -r2.xyz + r3.xyz;
	r2.z = CubeParam.z;
	r0.w = -r2.z + 1;
	r0.xyz = r1.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
