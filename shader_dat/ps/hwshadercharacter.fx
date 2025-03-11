float4 g_MatrialColor : register(c62);
sampler g_Sampler0 : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler0, texcoord);
	o = r0 * g_MatrialColor;

	return o;
}
