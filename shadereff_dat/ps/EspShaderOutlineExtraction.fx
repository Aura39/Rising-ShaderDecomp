float4 g_BlendColor : register(c186);
float4 g_MatrialColor : register(c184);
float4 g_OutLineRate : register(c185);
sampler g_Sampler0 : register(s0);
float4 g_TargetOffSet : register(c187);

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.x = 1 / texcoord.w;
	r0.xy = r0.xx * texcoord.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.zw = r0.xy + g_TargetOffSet.xy;
	r1 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r0.x = r0.x * g_OutLineRate.x;
	r0.y = r1.x * g_OutLineRate.x;
	r0.z = r1.x * -g_OutLineRate.x + g_OutLineRate.z;
	r0.x = -abs(r0.x) + abs(r0.y);
	r0.x = -abs(r0.x) + g_OutLineRate.y;
	r1 = g_BlendColor;
	r1 = (r0.x >= 0) ? r1 : g_MatrialColor;
	o = (r0.z >= 0) ? r1 : g_BlendColor;

	return o;
}
