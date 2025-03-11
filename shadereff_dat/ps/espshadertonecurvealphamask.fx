float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.w = g_Rate.y * r0.w + g_Rate.x;
	r1 = r0.w + -0.0001;
	clip(r1);
	r1 = tex2D(g_Sampler0, texcoord);
	r0.xyz = r1.xyz;
	o = r0 * g_MatrialColor;

	return o;
}
