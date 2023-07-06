float4 g_MatrialColor;
sampler g_Sampler0;
float4 g_UvParam0;

float4 main(float2 texcoord1 : TEXCOORD1) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xy = texcoord1.xy * g_UvParam0.xy + g_UvParam0.zw;
	r0 = tex2D(g_Sampler0, r0);
	r1.w = g_MatrialColor.w;
	r1 = r0.w * r1.w + -0.01;
	r0 = r0 * g_MatrialColor;
	o = r0;
	clip(r1);

	return o;
}
