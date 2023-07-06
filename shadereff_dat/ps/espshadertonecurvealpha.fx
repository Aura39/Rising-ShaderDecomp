float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler0, texcoord);
	r0.w = g_Rate.y * r0.w + g_Rate.x;
	o = r0 * g_MatrialColor;
	r0 = r0.w + -0.0001;
	clip(r0);

	return o;
}
