float4 g_MatrialColor : register(c184);
sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_SamplerTexture, texcoord);
	r1 = float4(0, 0.019886363, 0, 0.0085227275) + texcoord.xyxy;
	r2 = tex2D(g_SamplerTexture, r1);
	r1 = tex2D(g_SamplerTexture, r1.zwzw);
	r0 = r2 * 0.45 + r0;
	r0 = r1 * 0.8 + r0;
	r1 = float4(0, -0.019886363, 0, -0.0085227275) + texcoord.xyxy;
	r2 = tex2D(g_SamplerTexture, r1);
	r1 = tex2D(g_SamplerTexture, r1.zwzw);
	r0 = r2 * 0.45 + r0;
	r0 = r1 * 0.8 + r0;
	r0 = r0 * g_MatrialColor;
	o = r0 * 0.2857143;

	return o;
}
