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
	float3 r2;
	r0.w = g_MatrialColor.w;
	r0.x = r0.w + -g_Color2.w;
	r1 = tex2D(g_Sampler1, texcoord);
	r0.y = -r1.w + 1;
	r0.x = -r0.x + r0.y;
	r0.y = -r0.y + g_MatrialColor.w;
	r0.x = (r0.x >= 0) ? 1 : 0;
	r1 = tex2D(g_Sampler0, texcoord);
	r1 = r1 * g_MatrialColor;
	r2.xyz = r1.xyz * g_Color2.xyz;
	o.xyz = r2.xyz * r0.xxx + r1.xyz;
	r0.z = r1.w * g_Rate.x;
	r0.x = r0.x * r0.z;
	o.w = (r0.y >= 0) ? r0.x : 0;

	return o;
}
