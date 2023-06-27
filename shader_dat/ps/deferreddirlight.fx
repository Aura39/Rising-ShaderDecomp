sampler g_AlbedoSampler;
float4 g_CameraParam;
sampler g_NormalSampler;
sampler g_SpecMaskSampler;
float4 g_TargetUvParam;
sampler g_Z_ShadowSampler;
sampler g_Z_ShadowSampler2;
float4 g_finalColor_enhance;
float4 g_lightCol;
float4 g_lightDir;
sampler g_specPow;
float4 prefogcolor_enhance;

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
	float4 r4;
	float4 r5;
	r0.xy = g_TargetUvParam.xy + i.texcoord.xy;
	r1 = tex2D(g_NormalSampler, r0);
	r0.z = r1.w + -0.495;
	r0.w = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r0.w;
	r2.x = max(r0.z, 0);
	r0.z = r2.x * -0.5 + r1.w;
	r1.xyz = r1.xyz * 2 + -1;
	r0.w = r0.z + -0.245;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r1.w = max(r0.w, 0);
	r0.z = r1.w * -0.25 + r0.z;
	r3.y = r0.z * 4;
	r4 = tex2D(g_Z_ShadowSampler, r0);
	r0.z = r4.x * g_CameraParam.y + g_CameraParam.x;
	r2.yzw = r0.zzz * i.texcoord1.xyz;
	r0.z = dot(-r2.yzw, -r2.yzw);
	r0.z = 1 / sqrt(r0.z);
	r2.yzw = -r2.yzw * r0.zzz + g_lightDir.xyz;
	r4.xyz = normalize(r2.yzw);
	r0.z = dot(r4.xyz, r1.xyz);
	r0.w = dot(g_lightDir.xyz, r1.xyz);
	r1.x = max(r0.z, 0);
	r0.z = -r1.x + 1;
	r4 = tex2D(g_SpecMaskSampler, r0);
	r3.x = r0.z * -r4.w + r1.x;
	r3 = tex2D(g_specPow, r3);
	r0.z = r4.z * 5;
	r1.xyz = r3.xyz * r0.zzz;
	r3 = tex2D(g_AlbedoSampler, r0);
	r5 = tex2D(g_Z_ShadowSampler2, r0);
	r0.xyz = r1.www + r3.xyz;
	r2.yzw = r0.www * r3.xyz;
	r0.w = r0.w + -0.5;
	r1.w = max(r0.w, 0);
	r0.w = r1.w + r3.w;
	r1.w = -r4.x + 1;
	r3.xyz = r1.www * r3.xyz;
	r3.xyz = r3.xyz * 0.5;
	r2.yzw = r2.yzw * r4.xxx + r3.xyz;
	r0.xyz = r1.xyz * r0.xyz + r2.yzw;
	r0.xyz = r0.xyz * g_lightCol.xyz;
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r2.xxx * r0.xyz;
	r0.xyz = r5.zzz * r0.xyz;
	r1.xyz = prefogcolor_enhance.xyz;
	r1.xyz = r1.xyz * g_finalColor_enhance.xyz;
	o.xyz = r0.xyz * r1.xyz;
	o.w = 1;

	return o;
}
