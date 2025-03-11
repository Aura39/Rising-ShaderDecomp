float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.w = g_MatrialColor.w;
	r0.x = -r0.w + g_Rate.w;
	r1 = tex2D(g_Sampler0, texcoord);
	r0.x = r1.w * g_MatrialColor.w + -r0.x;
	r0.yzw = r1.xyz * g_MatrialColor.xyz;
	o.xyz = r0.yzw;
	o.w = r0.x * g_Rate.x;

	return o;
}
