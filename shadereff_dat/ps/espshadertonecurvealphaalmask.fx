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
	r0 = tex2D(g_Sampler1, texcoord);
	r0.x = g_Rate.y * r0.w + g_Rate.x;
	r1 = tex2D(g_Sampler0, texcoord);
	r2 = r1.w * r0.x + -0.0001;
	r1.w = r0.x * r1.w;
	o = r1 * g_MatrialColor;
	clip(r2);

	return o;
}
