sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
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
sampler normalmap_sampler : register(s4);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
	float4 r5;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r1.xyz = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r2.xyz = normalize(r1.xyz);
	r1.x = dot(r2.xyz, i.texcoord3.xyz);
	r2.x = pow(r1.x, specularParam.z);
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = r1.y * r1.z;
	r1.x = (-r1.x >= 0) ? 0 : r1.z;
	r1.x = r2.x * r1.x;
	r1.yzw = r1.yyy * light_Color.xyz;
	r1.xyz = r1.xxx * r1.yzw;
	r1.w = 1 / i.texcoord7.w;
	r2.xy = r1.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(ShadowCast_Tex_sampler, r2);
	r1.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r1.w = -r1.w + 1;
	r1.w = -r2.x + r1.w;
	r1.w = r1.w + g_ShadowUse.x;
	r2.x = frac(-r1.w);
	r1.w = r1.w + r2.x;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = ambient_rate_rate.xyz;
	r2.xyz = r1.www * r2.xyz + ambient_rate.xyz;
	r2.xyz = r2.xyz + i.texcoord2.xyz;
	r1.w = abs(specularParam.x);
	r1.xyz = r1.www * r1.xyz;
	r3.xy = -r0.yy + r0.xz;
	r1.w = max(abs(r3.x), abs(r3.y));
	r1.w = r1.w + -0.015625;
	r2.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r0.xz = (r1.ww >= 0) ? r0.yy : r0.xz;
	r1.w = 1 / ambient_rate.w;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r3.xyz = r0.xyz * r1.www;
	r0.xyz = r0.xyz * r1.www + specularParam.www;
	r2.xyz = r2.xyz * r3.xyz;
	r4.xy = g_All_Offset.xy;
	r4.xy = i.texcoord.xy * tile.xy + r4.xy;
	r4 = tex2D(normalmap_sampler, r4);
	r5 = tex2D(cubemap_sampler, i.texcoord4);
	r5 = r5 * ambient_rate_rate.w;
	r4.xyz = r4.www * r5.xyz;
	r0.w = r5.w * CubeParam.y + CubeParam.x;
	r4.xyz = r0.www * r4.xyz;
	r3.xyz = r3.xyz * r4.xyz;
	r5.xyz = r3.xyz * CubeParam.zzz + r2.xyz;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r2.xyz = r2.xyz * -r3.xyz + r5.xyz;
	r0.xyz = r1.xyz * r0.xyz + r2.xyz;
	r1.z = CubeParam.z;
	r0.w = -r1.z + 1;
	r0.xyz = r4.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;

	return o;
}
