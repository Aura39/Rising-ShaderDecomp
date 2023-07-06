float4 g_MatrialColor;

float4 main(float4 color : COLOR) : COLOR
{
	float4 o;

	o = g_MatrialColor * color;

	return o;
}
