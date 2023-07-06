float4 g_AlphaRate;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.w = g_AlphaRate.y * r0.w + g_AlphaRate.x;
	r1 = r0.w + -0.0001;
	clip(r1);
	r1 = tex2D(g_Sampler0, texcoord);
	r0.xyz = g_Rate.yyy * r1.xyz + g_Rate.xxx;
	o = r0 * g_MatrialColor;

	return o;
}
