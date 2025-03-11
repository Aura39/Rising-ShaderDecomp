sampler g_Sampler0 : register(s0);
float2 g_offset1 : register(c184);
float2 g_offset2 : register(c185);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler0, texcoord);
	r0.xy = r0.xy + -0.5;
	r0.xy = r0.xy * 0.016;
	r1 = float4(0, 0, 0, 1);
	r0.z = 0;
	for (int i0 = 0; i0 < 8; i0++) {
		r2.xy = r0.xy * r0.zz + texcoord.xy;
		r2 = tex2D(g_Sampler0, r2);
		r1 = r1 + r2;
		r0.z = r0.z + 1;
	}
	r0 = r1 * 0.125;
	r1.xy = g_offset1.xy;
	r1.xy = r1.xy + g_offset2.xy;
	o.xy = r1.xy * 1E-11 + r0.xy;
	o.zw = r0.zw;

	return o;
}
