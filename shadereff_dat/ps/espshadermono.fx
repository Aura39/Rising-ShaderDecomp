float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1.x = dot(r0.xyz, 0.298912);
	r1.xyz = -r0.xyz + r1.xxx;
	r1.w = 0;
	r0 = g_Rate.x * r1 + r0;
	r1.w = g_MatrialColor.w;
	r1 = r0.w * r1.w + -0.0001;
	r0 = r0 * g_MatrialColor;
	o = r0;
	clip(r1);

	return o;
}
