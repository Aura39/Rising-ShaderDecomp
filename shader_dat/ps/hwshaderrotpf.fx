float4 g_MatrialColor : register(c62);

float4 main() : COLOR
{
	float4 o;

	o = g_MatrialColor;

	return o;
}
