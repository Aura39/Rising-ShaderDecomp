sampler g_Sampler0;
float2 g_direction;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = 0.00048828125 + texcoord.xy;
	r1.yz = float2(0.00048828125, 0.001953125);
	r0.zw = g_direction.xy * -r1.yy + r0.xy;
	r2 = tex2D(g_Sampler0, r0);
	r2.z = 0.0029296875;
	r0.xy = g_direction.xy * r2.zz + r0.zw;
	r3 = tex2D(g_Sampler0, r0);
	r0.x = -r2.x + r3.x;
	r0.x = r0.x * 1.442695;
	r0.x = exp2(r0.x);
	r0.x = r0.x * 0.5 + 0.5;
	r0.x = log2(r0.x);
	r0.x = r0.x * 0.6931472 + r2.x;
	r1.xy = g_direction.xy * r1.zz + r0.zw;
	r2 = tex2D(g_Sampler0, r0.zwzw);
	r1 = tex2D(g_Sampler0, r1);
	r0.y = -r2.x + r1.x;
	r0.y = r0.y * 1.442695;
	r0.y = exp2(r0.y);
	r0.y = r0.y * 0.5 + 0.5;
	r0.y = log2(r0.y);
	r0.y = r0.y * 0.6931472 + r2.x;
	r0.x = -r0.y + r0.x;
	r0.x = r0.x * 1.442695;
	r0.x = exp2(r0.x);
	r0.x = r0.x * 0.5 + 0.5;
	r0.x = log2(r0.x);
	o = r0.x * 0.6931472 + r0.y;

	return o;
}
