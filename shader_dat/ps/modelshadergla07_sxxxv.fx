sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler RefractMap_sampler : register(s12);
float4 Refract_Param : register(c46);
sampler ShadowCast_Tex_sampler : register(s10);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap_sampler : register(s1);
float4 finalcolor_enhance : register(c78);
float3 fog : register(c67);
float4 fresnelParam : register(c47);
float4 g_All_Offset : register(c76);
float2 g_ShadowFarInvPs : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 prefogcolor_enhance : register(c77);
float3 private_lightDir : register(c44);
float2 private_lightParam : register(c45);
float4 specularParam : register(c41);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
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
	r0.z = dot(lightpos.xyz, r1.xyz);
	r1.x = pow(r0.y, specularParam.z);
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.y = (-abs(r0.w) >= 0) ? 0 : 1;
	r0.y = (-r0.y >= 0) ? 0 : r1.y;
	r1.y = abs(r0.w) * r1.y;
	r2.xyz = abs(r0.www) * light_Color.xyz;
	r2.xyz = r2.xyz * r0.xxx + i.texcoord2.xyz;
	r1.yzw = r1.yyy * light_Color.xyz;
	r0.y = r1.x * r0.y;
	r1.xyz = r0.yyy * r1.yzw;
	r0.xyw = r0.xxx * r1.xyz;
	r1.z = 1;
	r1.x = r1.z + -fresnelParam.x;
	r2.w = max(r0.z, r1.x);
	r0.z = r2.w + -1;
	r1.x = 1 / r2.w;
	r0.z = (r0.z >= 0) ? 1 : r1.x;
	r0.xyz = r0.zzz * r0.xyw;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.w = 1 / i.texcoord8.w;
	r1.xy = r0.ww * i.texcoord8.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1.xy = i.texcoord3.xy * -Refract_Param.yy + r1.xy;
	r3 = tex2D(RefractMap_sampler, r1);
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r4 = tex2D(Color_1_sampler, r1);
	r1.xy = -r4.yy + r4.xz;
	r0.w = max(abs(r1.x), abs(r1.y));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r4.xz = (r0.ww >= 0) ? r4.yy : r4.xz;
	r0.w = r4.w * ambient_rate.w;
	r1.xyw = lerp(r3.xyz, r4.xyz, Refract_Param.xxx);
	r2.xyz = r2.xyz * r1.xyw;
	r3.xyz = r1.xyw * ambient_rate.xyz;
	r2.xyz = r3.xyz * ambient_rate_rate.xyz + r2.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r2.w = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r2.www * r3.xyz;
	r4.xyz = r1.xyw * r3.xyz;
	r5.xyz = r4.xyz * CubeParam.zzz + r2.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r2.xyz = r2.xyz * -r4.xyz + r5.xyz;
	r4.xyz = r1.xyw + specularParam.www;
	r2.xyz = r0.xyz * r4.xyz + r2.xyz;
	r0.xyz = r0.xyz * r4.xyz;
	r1.z = r1.z + -CubeParam.z;
	r2.xyz = r3.xyz * r1.zzz + r2.xyz;
	r3.xyz = normalize(-private_lightDir.xyz);
	r1.z = dot(r3.xyz, i.texcoord3.xyz);
	r2.w = 1 / private_lightParam.y;
	r1.z = r1.z * -r2.w + 1;
	r1.xyz = r1.zzz * r1.xyw;
	r1.xyz = r1.xyz * private_lightParam.xxx + r2.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	r1.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	r2.x = max(r0.x, r0.y);
	r3.x = max(r2.x, r0.z);
	r0.x = r3.x * specularParam.x;
	r0.y = max(CubeParam.x, CubeParam.y);
	r0.x = r3.w * r0.y + r0.x;
	r2.x = max(r0.x, r0.w);
	r1.w = r2.x * prefogcolor_enhance.w;
	o = r1 * finalcolor_enhance;

	return o;
}
