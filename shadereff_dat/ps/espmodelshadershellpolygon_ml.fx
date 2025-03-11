float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_UvParam0 : register(c186);
float4 g_UvParam1 : register(c187);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.xy = texcoord.xy * g_UvParam1.xy + g_UvParam1.zw;
	r0 = tex2D(g_Sampler1, r0);
	r1.w = g_MatrialColor.w;
	r1 = r0.w * r1.w + -0.01;
	clip(r1);
	r1.xy = texcoord.xy * g_UvParam0.xy + g_UvParam0.zw;
	r1 = tex2D(g_Sampler0, r1);
	r0.xyz = r1.xyz;
	r0 = r0 * g_MatrialColor;
	o = r0;

	return o;
}
