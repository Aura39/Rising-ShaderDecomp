float4 g_Color2 : register(c186);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.x = -r0.w + 1;
	r0.y = -r0.x + g_MatrialColor.w;
	r1 = tex2D(g_Sampler0, texcoord);
	r2 = r1 * g_MatrialColor;
	r0.z = r2.w * g_Rate.x;
	r2.xyz = r2.xyz * g_Color2.xyz;
	o.w = (r0.y >= 0) ? r0.z : 0;
	r0.w = g_MatrialColor.w;
	r0.y = r0.w + -g_Color2.w;
	r0.x = -r0.y + r0.x;
	r0.xyz = (r0.xxx >= 0) ? r2.xyz : 0;
	o.xyz = r1.xyz * g_MatrialColor.xyz + r0.xyz;

	return o;
}
