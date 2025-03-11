float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
float4 g_UvParam0 : register(c186);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xy = texcoord.xy * g_UvParam0.xy + g_UvParam0.zw;
	r0 = tex2D(g_Sampler0, r0);
	r1.w = g_MatrialColor.w;
	r1 = r0.w * r1.w + -0.01;
	r0 = r0 * g_MatrialColor;
	o = r0;
	clip(r1);

	return o;
}
