float4 g_BlendRate;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = tex2D(g_Sampler1, texcoord);
	r2 = lerp(r1, r0, g_BlendRate.x);
	r0 = r2.w + -0.0001;
	clip(r0);
	r2.xyz = g_Rate.yyy * r2.xyz + g_Rate.xxx;
	o = r2 * g_MatrialColor;

	return o;
}
