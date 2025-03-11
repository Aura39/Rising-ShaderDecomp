float4 g_AlphaRate : register(c186);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.x = g_AlphaRate.y * r0.w + g_AlphaRate.x;
	r1 = tex2D(g_Sampler0, texcoord);
	r2 = r1.w * r0.x + -0.0001;
	r0.w = r0.x * r1.w;
	r0.xyz = g_Rate.yyy * r1.xyz + g_Rate.xxx;
	o = r0 * g_MatrialColor;
	clip(r2);

	return o;
}
