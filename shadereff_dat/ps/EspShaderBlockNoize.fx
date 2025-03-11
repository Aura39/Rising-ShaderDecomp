float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xy = -0.5 + texcoord.xy;
	r0.xy = r0.xy * g_Rate.yy;
	r0.zw = frac(r0.xy);
	r0.xy = -r0.zw + r0.xy;
	r0.xy = r0.xy + 0.5;
	r1.y = 0.5;
	r0.xy = r0.xy * g_Rate.xx + r1.yy;
	r0 = tex2D(g_Sampler0, r0);
	o = r0 * g_MatrialColor;

	return o;
}
