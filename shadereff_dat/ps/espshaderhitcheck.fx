float4 g_MatrialColor;
sampler g_Sampler0;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = i.texcoord1.x;
	clip(r0);
	r0.x = i.texcoord1.x;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1.w = r0.x * r1.w;
	o = r1 * g_MatrialColor;

	return o;
}
