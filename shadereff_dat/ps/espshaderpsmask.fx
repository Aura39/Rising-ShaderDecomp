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
	r0.x = -r0.w + 1;
	r0.x = -r0.x + g_MatrialColor.w;
	r1 = tex2D(g_Sampler0, texcoord);
	r1 = r1 * g_MatrialColor;
	r0.y = r1.w * g_Rate.x;
	o.xyz = r1.xyz;
	o.w = (r0.x >= 0) ? r0.y : 0;

	return o;
}
