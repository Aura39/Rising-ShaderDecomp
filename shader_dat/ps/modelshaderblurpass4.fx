sampler g_AmbientSampler;
sampler g_LightSampler;
float4 g_MatrialColor;
sampler g_ZSampler;
float3 g_fogCol;
float4 g_fogParam;
float4 g_preFogEnhanceColor;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_ZSampler, texcoord);
	r0.x = g_fogParam.w * -r0.x + g_fogParam.x;
	r1 = tex2D(g_LightSampler, texcoord);
	r2 = tex2D(g_AmbientSampler, texcoord);
	r0.yzw = r2.xyz * g_preFogEnhanceColor.xyz + r1.xyz;
	o.w = r2.w;
	r1.xyz = g_fogCol.xyz;
	r0.yzw = r0.yzw * g_MatrialColor.xyz + -r1.xyz;
	o.xyz = r0.xxx * r0.yzw + g_fogCol.xyz;

	return o;
}
