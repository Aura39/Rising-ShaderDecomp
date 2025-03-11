float4 g_BlendRate : register(c186);
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
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = tex2D(g_Sampler1, texcoord);
	r2 = lerp(r1, r0, g_BlendRate.x);
	r2.w = g_Rate.y * r2.w + g_Rate.x;
	o = r2 * g_MatrialColor;
	r0 = r2.w + -0.0001;
	clip(r0);

	return o;
}
