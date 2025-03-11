float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = g_MatrialColor * i.texcoord1;
	r2 = r0.w * r1.w + -0.001;
	r0 = r0 * r1;
	o = r0;
	clip(r2);

	return o;
}
