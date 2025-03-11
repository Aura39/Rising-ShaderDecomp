float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = r0.w + -0.001;
	r0 = r0 * g_MatrialColor;
	clip(r1);
	o.xyz = lerp(g_MatrialColor.xyz, r0.xyz, g_MatrialColor.www);
	r1.w = g_MatrialColor.w;
	r0.x = -r1.w + 1;
	o.w = r0.x * r0.w;

	return o;
}
