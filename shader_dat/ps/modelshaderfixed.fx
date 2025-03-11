float4 g_MatrialColor : register(c192);
sampler g_Sampler0 : register(s0);
float g_SetColor : register(c189);
float g_SetNormal : register(c190);
float4 g_SetShaderPerformance : register(c188);
float g_SetTangent : register(c191);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = r0.w + g_MatrialColor.w;
	clip(r1);
	r1.x = g_SetColor.x;
	r1.x = r1.x + g_SetNormal.x;
	r1.x = r1.x + g_SetTangent.x;
	r1.x = r1.x + g_SetShaderPerformance.w;
	r1.y = -r1.x + 1;
	r1.x = r1.x + -1;
	r0 = r0 * r1.y;
	r0 = (r1.x >= 0) ? 0 : r0;
	r0 = i.texcoord2 * g_SetNormal.x + r0;
	r0 = i.texcoord1 * g_SetColor.x + r0;
	r0 = i.texcoord3 * g_SetTangent.x + r0;
	o = r0 + g_SetShaderPerformance;

	return o;
}
