float4 g_BlendRate : register(c185);
float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = tex2D(g_Sampler2, texcoord);
	r2.xyz = lerp(r1.xyz, r0.xyz, g_BlendRate.xxx);
	r0 = tex2D(g_Sampler1, texcoord);
	r2.w = r0.w;
	o = r2 * g_MatrialColor;

	return o;
}
