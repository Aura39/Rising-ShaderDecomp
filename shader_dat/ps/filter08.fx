float4 g_MatrialColor : register(c184);
sampler g_Sampler : register(s0);
float4 g_plusAlpha : register(c185);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler, texcoord);
	o.xyz = r0.xyz * g_MatrialColor.xyz;
	o.w = g_plusAlpha.w;

	return o;
}
