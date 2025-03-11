float4 g_MatrialColor : register(c184);
float4 g_MosaicRate : register(c185);
sampler g_Sampler0 : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float2 r1;
	r0.xy = g_MosaicRate.xx * texcoord.xy;
	r0.zw = frac(r0.xy);
	r1.xy = (-r0.zw >= 0) ? 0 : 1;
	r0.zw = r0.xy + -r0.zw;
	r0.xy = (r0.xy >= 0) ? 0 : r1.xy;
	r0.xy = r0.xy + r0.zw;
	r0.xy = r0.xy * g_MosaicRate.yy;
	r0 = tex2D(g_Sampler0, r0);
	o = r0 * g_MatrialColor;

	return o;
}
