float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, texcoord);
	r1 = tex2D(g_Sampler0, texcoord);
	r1.w = r0.w * r1.w;
	o = r1 * g_MatrialColor;

	return o;
}
