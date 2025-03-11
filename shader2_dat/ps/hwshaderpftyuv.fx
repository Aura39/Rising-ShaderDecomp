float4 g_MatrialColor : register(c62);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler2, texcoord);
	r0.x = r0.w + -0.5;
	r0.xy = r0.xx * float2(1.596, 0.813);
	r1 = tex2D(g_Sampler1, texcoord);
	r0.z = r1.w + -0.5;
	r0.y = r0.z * -0.392 + -r0.y;
	r0.z = r0.z * 2.017;
	r1 = tex2D(g_Sampler0, texcoord);
	r0.w = r1.w + -0.0625;
	r1.y = r0.w * 1.164 + r0.y;
	r1.w = 1;
	r1.x = r0.w * 1.164 + r0.x;
	r1.z = r0.w * 1.164 + r0.z;
	o = r1 * g_MatrialColor;

	return o;
}
