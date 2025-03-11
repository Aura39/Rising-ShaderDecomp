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
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0.x = -0.01;
	r0 = r0.w * g_MatrialColor.w + r0.x;
	clip(r0);
	r0.x = dot(i.texcoord1.xyz, i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.y = 1 / i.texcoord1.w;
	o.x = r0.x * -r0.y + 1;
	o.yzw = float3(-0.01, 0, 0);

	return o;
}
