float g_Bright;
float g_DistortionScale;
sampler g_NormalSampler;
float3 g_NormalScale;
sampler g_SceneSampler;
float4 g_TargetUvParam;
float3 g_lightCol;
float3 g_lihtdir;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r0.zw = r0.xy * 4;
	r1 = tex2D(g_NormalSampler, r0.zwzw);
	r1.xyz = r1.xyz * 2 + -1;
	r2.xyz = r1.xyz * g_NormalScale.xyz;
	r0.xy = r1.xy * -g_DistortionScale.xx + r0.xy;
	r0 = tex2D(g_SceneSampler, r0);
	r1.xyz = normalize(r2.xyz);
	r1.x = dot(g_lihtdir.xyz, r1.xyz);
	r1.xyz = r1.xxx * g_lightCol.xyz;
	r1.xyz = r1.xyz * 0.5 + 0.5;
	r0.xyz = r0.xyz * r1.xyz;
	o.w = r0.w;
	o.xyz = r0.xyz * g_Bright.xxx;

	return o;
}
