float4 g_Color2;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.w = g_MatrialColor.w;
	r0.x = r0.w + -g_Color2.w;
	r1 = tex2D(g_Sampler1, texcoord);
	r0.y = -r1.w + 1;
	r0.x = -r0.x + r0.y;
	r0.y = -r0.y + g_MatrialColor.w;
	r1 = tex2D(g_Sampler0, texcoord);
	r1 = r1 * g_MatrialColor;
	o.xyz = (r0.xxx >= 0) ? g_Color2.xyz : r1.xyz;
	r0.z = r1.w * g_Rate.x;
	r0.x = (r0.x >= 0) ? r0.z : 0;
	o.w = (r0.y >= 0) ? r0.x : 0;

	return o;
}