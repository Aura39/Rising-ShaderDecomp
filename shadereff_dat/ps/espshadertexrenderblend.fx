float4 g_MatrialColor;
sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = r0.w + -0.001;
	r0 = r0 * g_MatrialColor;
	clip(r1);
	o.xyz = r0.xyz * g_MatrialColor.www + g_MatrialColor.xyz;
	o.w = r0.w;

	return o;
}
