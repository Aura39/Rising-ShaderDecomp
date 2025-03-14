sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s1);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float2 g_ShadowFarInvPs : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
sampler specularmap_sampler : register(s3);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
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
	float4 r3;
	float3 r4;
	float3 r5;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(ShadowCast_Tex_sampler, r0);
	r0.y = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r0.y = -r0.y + 1;
	r0.x = -r0.x + r0.y;
	r0.x = r0.x + g_ShadowUse.x;
	r0.y = frac(-r0.x);
	r0.x = r0.y + r0.x;
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r0.yzw = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r1.xyz = normalize(r0.yzw);
	r0.y = dot(r1.xyz, i.texcoord3.xyz);
	r1.x = pow(r0.y, specularParam.z);
	r0.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = (-abs(r0.z) >= 0) ? 0 : 1;
	r0.y = (-r0.y >= 0) ? 0 : r0.w;
	r0.w = abs(r0.z) * r0.w;
	r1.yzw = abs(r0.zzz) * light_Color.xyz;
	r1.yzw = r1.yzw * r0.xxx + i.texcoord2.xyz;
	r2.xyz = r0.www * light_Color.xyz;
	r0.y = r1.x * r0.y;
	r0.yzw = r0.yyy * r2.xyz;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r3 = tex2D(specularmap_sampler, r2);
	r2 = tex2D(Color_1_sampler, r2);
	r0.yzw = r0.yzw * r3.xyz;
	r0.xyz = r0.xxx * r0.yzw;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r3.xy = -r2.yy + r2.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r0.w = r2.w * ambient_rate.w;
	r1.xyz = r1.yzw * r2.xyz;
	r3.xyz = r2.xyz * ambient_rate.xyz;
	r1.xyz = r3.xyz * ambient_rate_rate.xyz + r1.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r1.w = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r1.www * r3.xyz;
	r4.xyz = r2.xyz * r3.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r5.xyz = r4.xyz * CubeParam.zzz + r1.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r4.xyz + r5.xyz;
	r1.xyz = r0.xyz * r2.xyz + r1.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r2.z = CubeParam.z;
	r1.w = -r2.z + 1;
	r1.xyz = r3.xyz * r1.www + r1.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	o.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	r1.x = max(r0.x, r0.y);
	r2.x = max(r1.x, r0.z);
	r0.x = r2.x * specularParam.x;
	r0.y = max(CubeParam.x, CubeParam.y);
	r0.x = r3.w * r0.y + r0.x;
	r1.x = max(r0.x, r0.w);
	r0.x = r1.x * prefogcolor_enhance.w;
	o.w = r0.x;

	return o;
}
