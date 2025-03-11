sampler g_AlbedoSampler : register(s0);
float4 g_CameraParam : register(c193);
sampler g_NormalSampler : register(s1);
sampler g_SpecMaskSampler : register(s2);
sampler g_Z_ShadowSampler : register(s5);
sampler g_Z_ShadowSampler2 : register(s6);
float4 g_finalColor_enhance : register(c188);
float4 g_lightCol : register(c186);
float4 g_lightDir : register(c185);
sampler g_specPow : register(s4);
float4 prefogcolor_enhance : register(c187);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = float2(0.00048828125, 0.00069444446) + i.texcoord.xy;
	r1 = tex2D(g_Z_ShadowSampler, r0);
	r0.z = r1.x * g_CameraParam.y + g_CameraParam.x;
	r1.xyz = r0.zzz * i.texcoord1.xyz;
	r0.z = dot(-r1.xyz, -r1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r1.xyz = -r1.xyz * r0.zzz + g_lightDir.xyz;
	r2.xyz = normalize(r1.xyz);
	r1 = tex2D(g_NormalSampler, r0);
	r1.xyz = r1.xyz * 2 + -1;
	r0.z = dot(r2.xyz, r1.xyz);
	r0.w = dot(g_lightDir.xyz, r1.xyz);
	r1.x = max(r0.z, 0);
	r2 = tex2D(g_SpecMaskSampler, r0);
	r0.z = r1.x + -r2.w;
	r1.x = -r2.w + 1;
	r1.x = 1 / r1.x;
	r1.x = r0.z * r1.x;
	r0.z = r1.w + -0.495;
	r1.z = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r1.z;
	r1.z = max(r0.z, 0);
	r0.z = r1.z * -0.5 + r1.w;
	r1.y = r0.z + r0.z;
	r3 = tex2D(g_specPow, r1);
	r1.xyw = r3.xyz * g_lightCol.xyz;
	r1.xyw = r2.zzz * r1.xyw;
	r2 = tex2D(g_Z_ShadowSampler2, r0);
	r3 = tex2D(g_AlbedoSampler, r0);
	r0.xyz = r1.xyw * r2.www;
	r1.x = r0.w + -0.5;
	r2.x = max(r1.x, 0);
	r1.x = r2.x + r3.w;
	r2.xyz = r3.xyz * g_lightCol.xyz;
	r2.xyz = r0.www * r2.xyz;
	r2.xyz = r2.www * r2.xyz;
	r2.xyz = r1.xxx * r2.xyz;
	r0.xyz = r0.xyz * r1.xxx;
	r0.xyz = r1.zzz * r0.xyz;
	r0.xyz = r2.xyz * r1.zzz + r0.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz;
	o.xyz = r0.xyz * g_finalColor_enhance.xyz;
	o.w = 1;

	return o;
}
